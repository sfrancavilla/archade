# Archade
<p align="center">
<img width="auto" height="640" alt="archade" src="https://github.com/user-attachments/assets/78f38ec9-07db-4d7a-aeaa-54350a5df3ea" />
</p>

## Introduction
Archade is a collection of dotfiles and scripts to create a beautiful, efficient, and highly customizable Hyprland desktop environment on Arch Linux. It is inspired by the simplicity and power of projects like Omarchy.

## Features

**Modular & Themable**: Easily switch between different visual themes for all major applications using a single command.

**Layered Configuration**: A professional three-layer system (base, theme, user) for Hyprland that allows for safe updates and deep personalization.

**Optimized for Hyprland**: Includes pre-configured settings for key applications in the Hyprland ecosystem, such as Waybar, Kitty, Wofi, and more.

## Installation

Getting Archade up and running is straightforward. The main installation script automates the entire process, from installing necessary packages to setting up the configurations.

**Prerequisites**

Before you begin, ensure you have a base Arch Linux installation with a graphical environment (like Xorg or Wayland) and `git` installed.

**Steps**

1.  **Clone the Repository**

    Open a terminal and clone the Archade repository to your local machine.

    ```bash
    git clone https://github.com/your-username/archade.git
    cd archade
    ```
    *Replace `https://github.com/your-username/archade.git` with the actual URL of your repository.*

2.  **Make the Script Executable**

    You'll need to grant execute permissions to the main installation script.

    ```bash
    chmod +x install.sh
    ```

3.  **Run the Installer**

    Execute the script to begin the setup. The script will:
    - Install necessary packages using `pacman`.
    - Set up core applications for the Hyprland environment.
    - Install the required fonts, including Nerd Fonts.
    - Deploy the base configuration files.

    ```bash
    ./install.sh
    ```

4.  **System Reboot**

    The script will automatically reboot your system after the installation is complete. This is necessary to ensure all changes are applied correctly. Once your system restarts, you can log into your new Hyprland session.

## Customization (Your Personal Settings)
This project uses a layered configuration system to make customization safe and easy. This allows you to receive updates for the base configuration without creating conflicts with your personal tweaks.

The core idea is to use a special user.conf file for Hyprland. This file is ignored by Git, so your personal changes will never be overwritten by a git pull.

How to Add Your Personal Overrides
Follow these steps to create your personal configuration file for Hyprland:

Navigate to the Hyprland config directory. After running the main install.sh script, all your configurations are managed from the standard ~/.config/ directory.

```bash
cd ~/.config/hypr
```

Create your personal config file. A template is provided to get you started. Simply copy it to create your active user file.

```bash
cp user.conf.example user.conf
```

Edit your user.conf and add your settings. You can now add any valid Hyprland setting to this file. Since it's the very last file loaded, any setting you add here will override the defaults from the base or theme layers.

```bash
vim user.conf
```

### Example user.conf:

Let's say you want to use Alacritty as your default terminal and change the keybind for it. Your user.conf might look like this:

```bash
# This is my personal user.conf file.

# Override the default terminal application
$mainMod = SUPER
$terminal = alacritty

# Override the keybind for the terminal
bind = $mainMod, RETURN, exec, $terminal
```

By following this method, you can tailor the setup to your exact needs while still being able to easily update the core dotfiles.