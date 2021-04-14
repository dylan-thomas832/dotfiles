# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

import os
import socket
import subprocess

from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

# Main key set to "Windows key", aka "super"
mod = "mod4"
# Useful if we want alt
alt = "mod1"
# Set the terminal program here
terminal = os.path.expanduser("~/.local/bin/alacritty")

#### Key Maps ####

keys = [
    ### The essentials
    Key(
        [mod], "Return",
        lazy.spawn(terminal),
        desc='Launches My Terminal'
    ),
    Key(
        [mod, "shift"], "Return",
        # lazy.spawncmd(),
        # lazy.spawn("rofi -show drun")
        # lazy.spawn("dmenu_run -p 'Run: '"),
        lazy.spawn("rofi -show drun -config ~/.config/rofi/themes/dmenu.rasi -display-drun \"Run: \" -drun-display-format \"{name}\""),
        desc='Run Launcher'
    ),
    Key(
        [mod], "Tab",
        lazy.next_layout(),
        desc='Toggle through layouts'
    ),
    Key(
        [mod, "shift"], "c",
        lazy.window.kill(),
        desc='Kill active window'
    ),
    Key(
        [mod, "shift"], "r",
        lazy.restart(),
        desc='Restart Qtile'
    ),
    Key(
        [mod, "shift"], "q",
        lazy.shutdown(),
        desc='Shutdown Qtile'
    ),
    Key(
        ["control", "shift"], "v",
        lazy.spawn("code ."),
        desc='Open VS Code here'
    ),
    Key(
        ["control", "shift"], "e",
        lazy.spawn("vim ."),
        desc='Open vim here'
    ),
    ### Switch focus of monitors
    Key(
        [mod], "period",
        lazy.next_screen(),
        desc='Move focus to next monitor'
    ),
    Key(
        [mod], "comma",
        lazy.prev_screen(),
        desc='Move focus to prev monitor'
    ),
    ### Window controls
    Key(
        [mod], "k",
        lazy.layout.up(),
        desc='Move focus down in current stack pane'
    ),
    Key(
        [mod], "j",
        lazy.layout.down(),
        desc='Move focus up in current stack pane'
    ),
    Key(
        [mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc='Move windows down in current stack'
    ),
    Key(
        [mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc='Move windows up in current stack'
    ),
    Key(
        [mod], "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
    ),
    Key(
        [mod], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
    ),
    Key(
        [mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
    ),
    Key(
        [mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
    ),
    Key(
        [mod, "shift"], "f",
        lazy.window.toggle_floating(),
        desc='toggle floating'
    ),
    Key(
        [mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
    ),
    ### Stack controls
    Key(
        [mod, "shift"], "Tab",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'
    ),
    Key(
        [mod], "space",
        lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'
    ),
    Key(
        [mod, "shift"], "space",
        lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'
    ),

    ### Switch focus to specific monitor (out of three)
    # Key(
    #     [mod], "w",
    #     lazy.to_screen(0),
    #     desc='Keyboard focus to monitor 1'
    # ),
    # Key(
    #     [mod], "e",
    #     lazy.to_screen(1),
    #     desc='Keyboard focus to monitor 2'
    # ),
    # Key(
    #     [mod], "r",
    #     lazy.to_screen(2),
    #     desc='Keyboard focus to monitor 3'
    # ),
]

#### Groups ####

group_names = [
    ("DEV", {'layout': 'monadtall'}),
    ("SYS", {'layout': 'monadtall'}),
    ("DOC", {'layout': 'monadtall'}),
    ("VSC", {'layout': 'max'}),
    ("GFX", {'layout': 'floating'})
]
groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.extend(
        [
        Key([mod], str(i), lazy.group[name].toscreen()),         # Switch to another group
        Key([mod, "shift"], str(i), lazy.window.togroup(name)),  # Send current window to another group
        ]
    )

#### Layouts ####

layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": "e1acff",
    "border_normal": "1D2330"
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2),
    layout.Floating(**layout_theme)
]

colors = [
    ["#282c34", "#282c34"], # panel background
    ["#3d3f4b", "#434758"], # background for current screen tab
    ["#ffffff", "#ffffff"], # font color for group names
    ["#ff5555", "#ff5555"], # border line color for current tab
    ["#74438f", "#74438f"], # border line color for 'other tabs' and color for 'odd widgets'
    ["#4f76c7", "#4f76c7"], # color for the 'even widgets'
    ["#e1acff", "#e1acff"], # window name
    ["#ecbbfb", "#ecbbfb"]  # backbround for inactive screens
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

#### Widgets Settings ####

widget_defaults = dict(
    font='DejaVu Sans Mono',
    fontsize=12,
    padding=2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()

# odd_sep = widget.Sep(
#     linewidth = 0,
#     padding = 6,
#     foreground = colors[0],
#     background = colors[0]
# )

def init_widgets_list():
    widgets_list = [
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.GroupBox(
            font = "DejaVu Sans Mono",
            fontsize = 9,
            margin_y = 3,
            margin_x = 0,
            padding_y = 5,
            padding_x = 3,
            borderwidth = 3,
            active = colors[2],
            inactive = colors[7],
            rounded = False,
            highlight_color = colors[1],
            highlight_method = "line",
            this_current_screen_border = colors[6],
            this_screen_border = colors [4],
            other_current_screen_border = colors[6],
            other_screen_border = colors[4],
            foreground = colors[2],
            background = colors[0]
        ),
        widget.Prompt(
            prompt = prompt,
            font = "DejaVu Sans Mono",
            padding = 10,
            foreground = colors[3],
            background = colors[1]
        ),
        widget.Sep(
            linewidth = 0,
            padding = 40,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.WindowName(
            foreground = colors[6],
            background = colors[0],
            padding = 0
        ),
        # widget.Systray(
        #     background = colors[0],
        #     padding = 5
        # ),
        # odd_sep,
        # widget.TextBox(
        #     text = '',
        #     background = colors[0],
        #     foreground = colors[4],
        #     padding = 0,
        #     fontsize = 37
        # ),
        # widget.Net(
        #         interface = "enp6s0",
        #         format = '{down} ↓↑ {up}',
        #         foreground = colors[2],
        #         background = colors[4],
        #         padding = 5
        #         ),
        # widget.TextBox(
        #     text = '',
        #     background = colors[4],
        #     foreground = colors[5],
        #     padding = 0,
        #     fontsize = 37
        # ),
        # widget.TextBox(
        #     text = " 🌡 ",
        #     padding = 2,
        #     foreground = colors[2],
        #     background = colors[5],
        #     fontsize = 11
        # ),
        # widget.ThermalSensor(
        #          foreground = colors[2],
        #          background = colors[5],
        #          threshold = 90,
        #          padding = 5
        #          ),
        # widget.TextBox(
        #     text='',
        #     background = colors[5],
        #     foreground = colors[4],
        #     padding = 0,
        #     fontsize = 37
        # ),
        # widget.TextBox(
        #     text = " ⟳",
        #     padding = 2,
        #     foreground = colors[2],
        #     background = colors[4],
        #     fontsize = 14
        # ),
        # widget.CheckUpdates(
        #     update_interval = 1800,
        #     distro = "Ubuntu",
        #     display_format = "{updates} Updates",
        #     foreground = colors[2],
        #     mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e sudo apt upgrade -y')},
        #     background = colors[4]
        # ),
        # widget.TextBox(
        #     text = '',
        #     background = colors[4],
        #     foreground = colors[5],
        #     padding = 0,
        #     fontsize = 37
        # ),
        # widget.TextBox(
        #     text = " 🖬",
        #     foreground = colors[2],
        #     background = colors[5],
        #     padding = 0,
        #     fontsize = 14
        # ),
        # widget.Memory(
        #     foreground = colors[2],
        #     background = colors[5],
        #     mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e htop')},
        #     padding = 5
        # ),
        # widget.TextBox(
        #     text='',
        #     background = colors[5],
        #     foreground = colors[4],
        #     padding = 0,
        #     fontsize = 37
        # ),
        # widget.TextBox(
        #     text = " ₿",
        #     padding = 0,
        #     foreground = colors[2],
        #     background = colors[4],
        #     fontsize = 12
        # ),
        # widget.BitcoinTicker(
        #     foreground = colors[2],
        #     background = colors[4],
        #     padding = 5
        # ),
        # widget.TextBox(
        #     text = '',
        #     background = colors[4],
        #     foreground = colors[5],
        #     padding = 0,
        #     fontsize = 37
        # ),
        # widget.TextBox(
        #     text = " Vol:",
        #     foreground = colors[2],
        #     background = colors[5],
        #     padding = 0
        # ),
        # widget.Volume(
        #     foreground = colors[2],
        #     background = colors[5],
        #     padding = 5
        # ),
        # widget.TextBox(
        #     text = '',
        #     background = colors[5],
        #     foreground = colors[4],
        #     padding = 0,
        #     fontsize = 37
        # ),
        # widget.CurrentLayoutIcon(
        #     custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
        #     foreground = colors[0],
        #     background = colors[4],
        #     padding = 0,
        #     scale = 0.7
        # ),
        # widget.CurrentLayout(
        #     foreground = colors[2],
        #     background = colors[4],
        #     padding = 5
        # ),
        widget.TextBox(
            text = '\uE0B2',
            background = colors[4],
            foreground = colors[5],
            padding = 0,
            fontsize = 37
        ),
        widget.Clock(
            foreground = colors[2],
            background = colors[5],
            format = "%A, %B %d - %H:%M "
        ),
    ]
    print(len(widgets_list))
    return widgets_list


def init_screens():
    print(type(init_widgets_list()))
    return [
        Screen(top=bar.Bar(init_widgets_list(), 20, opacity=1.0)),
        # Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20)),
        # Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20))
    ]

# if __name__ in ["config", "__main__"]:
screens = init_screens()


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


# Drag floating layouts.
mouse = [
    Drag(
        [mod], "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [mod], "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click(
        [mod], "Button2",
        lazy.window.bring_to_front()
    )
]


dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False


floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    start_script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([start_script])
