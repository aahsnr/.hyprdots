{ config, lib, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          lightTheme = false;
          activeBorderColor = [ "#cba6f7" "bold" ];          # Catppuccin Mocha Mauve
          inactiveBorderColor = [ "#6c7086" ];        # Catppuccin Mocha Surface2
          optionsTextColor = [ "#89b4fa" ];             # Catppuccin Mocha Blue
          selectedLineBgColor = [ "#313244" ];        # Catppuccin Mocha Surface0
          selectedRangeBgColor = [ "#313244" ];       # Catppuccin Mocha Surface0
          searchingActiveBorderColor = [ "#fab387" ];     # Catppuccin Mocha Peach
          cherryPickedCommitBgColor = [ "#313244" ];  # Catppuccin Mocha Surface0
          cherryPickedCommitFgColor = [ "#a6e3a1" ];      # Catppuccin Mocha Green
          unstagedChangesColor = [ "#f38ba8" ];          # Catppuccin Mocha Red
          defaultFgColor = [ "#cdd6f4" ];                # Catppuccin Mocha Text
        };
        scrollHeight = 2;
        scrollPastBottom = true;
        mouseEvents = true;
        showFileTree = true;
        showRandomTip = true;
        showBranchCommitHash = true;
        showPanelJumps = true;
        showCommandLog = true;
        showIcons = true;
        nerdFontsVersion = "3";
        commitLength.show = true;
        splitDiff = "auto";
        border = "rounded";
        animateExpansion = true;
        portraitMode = "auto";
        filterMode = "substring";

        spinner = {
          frames = [ "⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏" ];
          rate = 50;
        };

        keybinding = {
          universal = {
            quit = "q";
            quit-alt1 = "<c-c>";
            return = "<esc>";
            quitWithoutChangingDirectory = "Q";
            togglePanel = "<tab>";
            prevItem = "k";
            nextItem = "j";
            prevItem-alt = "<up>";
            nextItem-alt = "<down>";
            prevPage = "<c-u>";
            nextPage = "<c-d>";
            scrollLeft = "H";
            scrollRight = "L";
            gotoTop = "gg";
            gotoBottom = "G";
            toggleRangeSelect = "v";
            rangeSelectDown = "<s-j>";
            rangeSelectUp = "<s-k>";
            prevBlock = "<left>";
            nextBlock = "<right>";
            prevBlock-alt = "h";
            nextBlock-alt = "l";
            nextTab = "]";
            prevTab = "[";
            nextScreenMode = "+";
            prevScreenMode = "_";
            undo = "z";
            redo = "<c-z>";
            filteringMenu = "<c-s>";
            diffingMenu = "W";
            diffingMenu-alt = "<c-e>";
            copyToClipboard = "<c-o>";
            openRecentRepos = "<c-r>";
            submitEditorText = "<enter>";
            extrasMenu = "@";
            toggleWhitespaceInDiffView = "<c-w>";
            increaseContextInDiffView = "}";
            decreaseContextInDiffView = "{";
          };

          status = {
            checkForUpdate = "u";
            recentRepos = "<enter>";
            allBranchesLogGraph = "a";
          };

          files = {
            commitChanges = "c";
            commitChangesWithoutHook = "w";
            amendLastCommit = "A";
            commitChangesWithEditor = "C";
            ignoreFile = "i";
            refreshFiles = "R";
            stashAllChanges = "s";
            viewStashOptions = "S";
            toggleStagedAll = "a";
            viewResetOptions = "D";
            fetch = "f";
            toggleTreeView = "`";
            openMergeTool = "M";
          };

          branches = {
            createPullRequest = "o";
            viewPullRequestOptions = "O";
            checkoutBranch = "<space>";
            forceCheckoutBranch = "F";
            rebaseBranch = "r";
            renameBranch = "R";
            mergeIntoCurrentBranch = "m";
            viewBranchOptions = "b";
            fastForward = "f";
            createTag = "T";
            setUpstream = "u";
            fetchRemote = "f";
          };

          commits = {
            squashDown = "s";
            renameCommit = "r";
            renameCommitWithEditor = "R";
            viewResetOptions = "g";
            markCommitAsFixup = "f";
            createFixupCommit = "F";
            squashAboveCommits = "S";
            moveDownCommit = "<c-j>";
            moveUpCommit = "<c-k>";
            amendToCommit = "A";
            pickCommit = "p";
            revertCommit = "t";
            cherryPickCopy = "c";
            pasteCommits = "v";
            tagCommit = "T";
            checkoutCommit = "<space>";
            resetCherryPick = "<c-R>";
            copyCommitAttributeToClipboard = "y";
            openInBrowser = "o";
            viewBisectOptions = "b";
            startInteractiveRebase = "i";
          };

          stash = {
            popStash = "g";
            renameStash = "r";
            applyStash = "a";
            dropStash = "d";
          };

          commitFiles = {
            checkoutCommitFile = "c";
          };

          main = {
            toggleSelectHunk = "a";
            pickBothHunks = "b";
            editSelectHunk = "e";
            openFile = "o";
            refreshStagingPanel = "r";
            stageSelection = "s";
            resetSelection = "d";
            togglePanel = "<tab>";
            prevConflict = "[";
            nextConflict = "]";
            selectPrevConflict = "<";
            selectNextConflict = ">";
            selectPrevHunk = "K";
            selectNextHunk = "J";
            undo = "z";
            redo = "<c-z>";
            toggleDragSelect = "v";
            toggleDragSelect-alt = "V";
            copyToClipboard = "y";
          };

          submodules = {
            init = "i";
            update = "u";
            bulkMenu = "b";
            delete = "d";
            enter = "<enter>";
          };

          commitMessage = {
            confirm = "<enter>";
            switchToEditor = "<c-e>";
          };
        };
      };

      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never --line-numbers --side-by-side";
        };
        commit = {
          signOff = true;
        };
        merging = {
          manualCommit = false;
          tool = "nvimdiff";
        };
        log = {
          order = "topo-order";
          showGraph = "when-maximised";
        };
        skipHookPrefix = "WIP";
        autoFetch = true;
        autoRefresh = true;
        fetchAll = true;
        branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --";
        allBranchesLogCmds = [
          "git log --graph --all --color=always --abbrev-commit --decorate --date=relative --pretty=medium"
        ];
        overrideGpg = false;
        disableForcePushing = false;
      };

      os = {
        editCommand = "nvim";
        editCommandTemplate = "{{editor}} {{filename}}";
        openCommand = "xdg-open";
        openLinkCommand = "xdg-open {{link}}";
      };

      update = {
        method = "prompt";
        days = 14;
      };

      refresher = {
        refreshInterval = 10;
        fetchInterval = 60;
      };

      disableStartupPopups = true;
      notARepository = "prompt";

      customCommands = [
        {
          key = "E";
          command = "git commit --amend --no-edit";
          context = "commits";
          description = "Amend commit without editing message";
        }
        {
          key = "n";
          command = "nvim {{.SelectedFile.Name}}";
          context = "files";
          description = "Open file in AstroNvim";
          inTerminal = true;
        }
        {
          key = "H";
          command = "nvim -c 'Telescope git_bcommits {{.SelectedFile.Name}}'";
          context = "files";
          description = "View file history with Telescope";
          inTerminal = true;
        }
        {
          key = "I";
          command = "git rebase -i {{.SelectedLocalCommit.Sha}}^";
          context = "commits";
          description = "Interactive rebase from selected commit";
          inTerminal = true;
        }
        {
          key = "B";
          command = "nvim -c 'Telescope git_branches'";
          context = "localBranches";
          description = "Browse branches with Telescope";
          inTerminal = true;
        }
        {
          key = "b";
          command = "nvim -c 'Git blame {{.SelectedFile.Name}}'";
          context = "files";
          description = "View git blame in AstroNvim";
          inTerminal = true;
        }
        {
          key = "v";
          command = "nvim -c 'G stash show -p {{.SelectedStashEntry.Index}}'";
          context = "stash";
          description = "View stash content in AstroNvim";
          inTerminal = true;
        }
      ];
    };
  };
}
