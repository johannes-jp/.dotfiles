import i3ipc
import pprint
import subprocess


def set_theme(image):
    subprocess.run(["wpg", "-s", image])


def on_workspace_focus(self, e):
    if e.current:
        workspace_num = int(e.current.name)
        if workspace_num == 1:
            set_theme("clouds.jpg")
        elif workspace_num == 2:
            set_theme("neon_rings.jpg")
        else:
            set_theme("neon_rings.jpg")


# testing for some sort of 'parent container becomes inactive' function
# def on_window_focus(i3, event):
# con = event.container
# pprint.pprint(vars(con))


i3 = i3ipc.Connection()
i3.on("workspace::focus", on_workspace_focus)
i3.on("window::focus", on_window_focus)
i3.main()
