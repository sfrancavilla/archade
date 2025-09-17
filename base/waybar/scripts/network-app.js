#!/usr/bin/gjs

import Gtk from 'gi://Gtk?version=4';
import Network from 'gi://AstalNetwork';

const app = new Gtk.Application({ application_id: 'com.archade.NetworkWidget' });

app.connect('activate', () => {
  const win = new Gtk.ApplicationWindow({
    application: app,
    title: 'Network',
    default_width: 220,
    default_height: 36,
  });

  const box = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 8, margin_top: 6, margin_bottom: 6, margin_start: 10, margin_end: 10 });

  const icon = new Gtk.Image({ pixel_size: 16 });
  const label = new Gtk.Label({ xalign: 0 });

  box.append(icon);
  box.append(label);

  const net = Network.get_default();
  const wifi = net.get_wifi();

  function refresh() {
    const ssid = wifi.get_ssid() ?? 'Wi-Fi off';
    const strength = wifi.get_enabled() ? `${wifi.get_strength()}%` : '';
    icon.set_icon_name(wifi.get_icon_name() || 'network-wireless-offline-symbolic');
    label.set_label([ssid, strength].filter(Boolean).join('  ·  '));
  }

  // update on property changes
  wifi.connect('notify::ssid', refresh);
  wifi.connect('notify::strength', refresh);
  wifi.connect('notify::icon-name', refresh);
  wifi.connect('state-changed', refresh);

  // click to toggle wifi on/off
  box.add_controller(
    (() => {
      const click = new Gtk.GestureClick();
      click.connect('released', () => wifi.set_enabled(!wifi.get_enabled()));
      return click;
    })()
  );

  refresh();
  win.set_child(box);
  win.present();
});

app.run([]);
