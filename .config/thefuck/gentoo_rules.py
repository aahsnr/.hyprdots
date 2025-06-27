from thefuck.utils import replace_command, for_app


@for_app("emerge")
def match_emerge_missing_use_flag(command):
    return "missing USE flag" in command.stderr.lower()


def get_new_command_emerge_use_flag(command):
    flag = command.stderr.split("missing USE flag")[-1].split("'")[1]
    return f'USE="{flag}" emerge {" ".join(command.script_parts[1:])}'


@for_app("eix")
def match_eix_no_matches(command):
    return "No matches found" in command.stderr


def get_new_command_eix_remote_search(command):
    return command.script.replace("eix", "eix -R")


@for_app("equery")
def match_equery_no_matches(command):
    return "No package found" in command.stderr


def get_new_command_equery_wildcard(command):
    return command.script + "*"
