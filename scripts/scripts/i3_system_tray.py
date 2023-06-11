import i3ipc
import time

# Create the connection to i3ipc
i3 = i3ipc.Connection()

# Open conky
i3.command("exec conky")
time.sleep(0.5)  # Allow some time for conky to open

i3.command("floating enable")
i3.command("move position 0 px 0 px")
time.sleep(0.5)  # Allow some time for conky to open

i3.command("floating disable")


# Split the container vertically
# i3.command("split v")

# Open typora
# i3.command("exec typora")
# time.sleep(0.5)  # Allow some time for typora to open

# Resize the parent container to be 400 px tall
i3.command("resize set 400 px")
