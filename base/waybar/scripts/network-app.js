#!/usr/bin/env gjs

// This is a standalone GTK4 application that scans for Wi-Fi networks using Astal
// and displays them in a custom, clickable pop-up window.

// Specify we are using GTK version 4.0
imports.gi.versions.Gtk = '4.0';

// Import the necessary libraries from the system
const { Gtk, GLib } = imports.gi;
const Astal = imports.gi.Astal;

// We build our UI inside a Gtk.Application class, which is standard practice.
class NetworkMenu extends Gtk.Application {
    constructor() {
        super({ application_id: 'it.archade.NetworkMenu' });
        this.window = null;
    }

    // This function is called when the application is activated (run).
    vfunc_activate() {
        // If the window doesn't exist yet, build it.
        if (!this.window) {
            this.window = new Gtk.ApplicationWindow({
                application: this,
                title: 'Available Wi-Fi Networks',
                default_width: 350,
                default_height: 400,
            });

            // Create a scrollable container in case the network list is long.
            const scrolledWindow = new Gtk.ScrolledWindow();
            this.window.set_child(scrolledWindow);

            // Create the list box that will hold our networks.
            const listBox = new Gtk.ListBox();
            listBox.set_selection_mode(Gtk.SelectionMode.SINGLE); // Allow single selection
            scrolledWindow.set_child(listBox);

            // --- GET AND DISPLAY NETWORKS using Astal ---
            const network = new Astal.Network();
            // This function scans for and returns an array of network objects.
            const available_networks = network.get_visible_networks("wifi");

            available_networks.forEach(net => {
                const row = new Gtk.ListBoxRow();
                const label = new Gtk.Label({
                    // Display the SSID (Wi-Fi name) and signal strength
                    label: `${net.ssid} (${net.signal_strength}%)`,
                    xalign: 0, // Align text to the left
                    margin_start: 12,
                    margin_top: 8,
                    margin_bottom: 8,
                    margin_end: 12,
                });
                row.set_child(label);
                // When a row is clicked ('activated'), call our function to connect.
                row.connect('activate', () => this._on_network_selected(row));
                listBox.append(row);
            });
        }

        // Show the window to the user.
        this.window.present();
    }

    // This function is called when a user clicks a network in the list.
    _on_network_selected(row) {
        const label_text = row.get_child().get_label();
        // Extract just the SSID from the line, e.g., "MyWifi (85%)" -> "MyWifi"
        const ssid = label_text.split(" (")[0];

        // Send a desktop notification to give the user feedback.
        GLib.spawn_command_line_async(`notify-send "Network Manager" "Attempting to connect to ${ssid}..."`);
        
        // Use nmcli (the system's network manager) to handle the connection.
        GLib.spawn_command_line_async(`nmcli device wifi connect "${ssid}"`);
        
        // Close the application window after making a selection.
        this.window.close();
    }
}

// --- RUN THE APPLICATION ---
const app = new NetworkMenu();
app.run(null); // The 'null' means we are not passing command-line arguments.
