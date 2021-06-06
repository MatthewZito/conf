# Personal Configurations

This directory houses configuration files for my personal Linux machine. I'll also share how you can do this in the following sections.

## How to Properly Track Your Dotfiles With Git (no symlinks required)

I use a bare git repository for easy tracking - no symlinks necessary; here's how:

First, we create a bare git repository. We'll create a folder called `.cfg` in our `$HOME` directory.
This is where our bare repo lives. A much-needed benefit here is we don't need to worry about accidentally tracking everything in `$HOME`.

```bash
git init --bare $HOME/.cfg
```

Next, let's alias this repository so we can manage our dotfiles from anywhere. Here, I'll demonstrate how you can add this to your `.bashrc`; personally, I use an alias for adding aliases to a special alias config :D (more on that below). Anyway...

Create the alias:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Add it to your `.bashrc`:

```bash
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

Third, we set the `--local` flag so git doesn't show us files we've yet to explicitly track. We only want to see what we want to see:

```bash
dotfiles config --local status.showUntrackedFiles no
```

Great! Now we can do things like:

```bash
dotfiles status
dotfiles add .tmux.conf .vimrc
dotfiles commit -S -m "add tmux and vim configs"
dotfiles push
```

Congratulations! You can also use branches to track settings for different machines or environments.

### New Environment Setup

If you have a new machine you want to configure:

1. Add the alias

```bash
# don't forget to also set in the current shell or source .bashrc before using
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

2. **gitignore the cloned dir** (this will mitigate weird recursion issues)

```bash
echo ".cfg" >> .gitignore
```

3. Clone it :
  
```bash
git clone --bare <git-repo-url> $HOME/.cfg
```

4. Checkout the contents into `$HOME` (you may need to backup existing files e.g. `.bashrc`)

```bash
dotfiles checkout
```

## Better Bash Configurations

I don't use `.bashrc` (or common alternatives), not in a traditional manner anyway. Using a single config for the many settings one can configure for bash is silly. Instead, my `.bashrc` sources from a special `.bash_conf` [directory](https://github.com/MatthewZito/dotfiles/tree/master/.bash_conf), which houses separate files for discrete bash configurations. I recommend any regular bash user do the same.

These configs are:

- *alias* persistent aliases; we can add to these using a custom command `mk_alias`
- *cmd* reusable functions - these are sourced for use during interactive shell sessions
- *env* PATHs, global environment variables, and shellopts
- *interactive* settings for interactive mode; these are sourced on every session
- *login* settings and configurations that need only be sourced upon login

There's also the `apps` and `scripts` directories under `.bash_conf`, which house app configs that are used by the shell environment and scripts used by the functions in `cmd.bash`, respectively. The domain here is typically:

- default configurations for various environments e.g. golang, npm / node, stack, et al
- scripts i.e. more complicated commands than can be crammed into `cmd.bash`

Last, we have the `.templates` [directory](https://github.com/MatthewZito/dotfiles/tree/master/.templates) which houses:

- dockerized dev environment - when launched, this will mount the present working directory as a temporary, linked volume
- templates for bootstrapping project defaults (e.g. for an npm package) - these are used by the `bootstrap` command
