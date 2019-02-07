"""PYTHONRC - Really Neat way to make the python shell fun and usable.

Copy this file to $HOME/.pythonrc.py
In windows, copy it to $HOMEDRIVE:$HOMEPATH/.pythonrc.py

This is called when interactive python interpreter is instructed to:
    import user
You can force this to import everytime by setting an environment variable:
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
It makes command history persistent, allows TAB expansion, adds time
stamp.
"""


class PythonRC:
    """Defines Python RC class."""

    histfile = None
    debug = None

    @classmethod
    def init(cls):
        """Initialize a nice environment to run in."""
        import os
        cls.debug = os.getenv('PYTHONRC_DEBUG')

        if os.getenv('NOPYTHONRC'):
            # Not loading the python environment
            cls.debug_print("Skipping loading the pythonrc environment stuff")
            return

        try:
            import readline
        except ImportError:
            readline = None
        cls.readline = readline

        if readline:
            # Set the history file
            cls.histfile = os.path.join(os.getenv('HOME', '.'), '.python_history')
            cls.debug_print("Using history file '%s'" % cls.histfile)

            # Read the history file
            if os.path.exists(cls.histfile):
                readline.read_history_file(cls.histfile)
                cls.debug_print("Using existing history information")
            else:
                cls.debug_print("Creating new history file")

            # Set the number of history items to 3000
            readline.set_history_length(3000)
            cls.debug_print("History size set to 3000")

            # Put a marker for the starting time.
            readline.add_history("# starting %s" % cls.strtime())
            cls.debug_print("Marked start of history file")

            # Allow Tab Completion
            import rlcompleter  # This sets up python specific completion pylint: disable=unused-import
            readline.parse_and_bind("tab: complete")
            cls.debug_print("Started completion")
        else:
            cls.debug_print("No readline available")

        # Set the prompts
        import sys
        sys.ps1 = "python%s> " % ".".join(map(str, sys.version_info[:2]))
        sys.ps2 = " " * (len(sys.ps1) - 2) + "> "
        cls.debug_print("Set prompts")

        # The the exit function
        import atexit
        atexit.register(cls.exit)
        cls.debug_print("Registered exit function")

    @classmethod
    def debug_print(cls, *msgs):
        """Debugging Print."""
        if cls.debug:
            for msg in msgs:
                print("PYTHONRC: %s" % msg)

    @classmethod
    def strtime(cls):
        """Return the time in a nicely formatted string."""
        import time
        str_format = "%A %I:%M %p, %B %d, %Y %Z"
        return time.strftime(str_format)

    @classmethod
    def exit(cls):
        """Run when everything exits."""
        cls.debug_print("Exiting...")
        if cls.readline:
            cls.readline.add_history("# leaving %s" % cls.strtime())
            cls.readline.write_history_file(cls.histfile)
        print("Exiting")


if __name__ == "__main__":
    PythonRC.init()
