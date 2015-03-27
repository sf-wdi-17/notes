# Introduction to Git & Github

## Objectives

Students will be able to...

1. identify the use cases for version control
2. describe what Git is
3. use Git to stage and commit files
4. utilize Github as a collaborative tool


### What is version control??

So before we begin I'd like you to copy this html into a file called index.html

```

	<!DOCTYPE html>
	<html>
		<head>
			<style>
		
			</style>
		</head>
	
		<body>
	
		</body>
	</html>
	
```

Make some changes. Add a header with your name and a list of your favorite things.

Now that you've got something, pair up with a neighbor and let's combine the two html files into one.

Let's imagine what would happen if we kept repeating this process until we have every student and their favorite things in one file.

  * This sucks right? 
  * Why do you guys think that this sucks? 
  * What could we do to make it better?

### Queue Git!

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

Git is hands down the most popular version control system in existence. It was created by Linus Torvalds, the same guy that made the kernel to the GNU Linux operating system.

Hopefully by now everyone has already downloaded a copy of git. If not go to [here](http://git-scm.com/download).

Open up command line and type in the command
```bash
$ git
```
You should see a something like

```bash
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
   branch     List, create, or delete branches
   checkout   Checkout a branch or paths to the working tree
   clone      Clone a repository into a new directory
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   fetch      Download objects and refs from another repository
   grep       Print lines matching a pattern
   init       Create an empty Git repository or reinitialize an existing one
   log        Show commit logs
   merge      Join two or more development histories together
   mv         Move or rename a file, a directory, or a symlink
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects
   rebase     Forward-port local commits to the updated upstream head
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index
   show       Show various types of objects
   status     Show the working tree status
   tag        Create, list, delete or verify a tag object signed with GPG

'git help -a' and 'git help -g' lists available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
```

This is a list of some of the most common git commands. If you're ever looking at a good place to get started, or you don't know what command to use, give the git command a try.

Okay. So make a directory that you're going to work in and change into it. And type:

```bash 
$ git init
```
We should get some sort of output like this:

```bash
Initialized empty Git repository in ... PATH_TO_INITIALIZED_REPO
```

Now that we've initialized the repository lets add a Readme file.

```bash
$ touch README.md
```

Now that there's a README.md file in our folder, lets see what the status of our git repo is. Run the command 'status' like this:

```bash
$ git status
```

Which should output something like:

```bash
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	README.md

nothing added to commit but untracked files present (use "git add" to track)
```

```bash
$ git add README.md
```

Then checking the status will give me something like

```bash
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   README.md
```

Now we're going to commit those changes

```bash
$ git commit -m "Put Message Here"
[master (root-commit) 37c5f18] Put Message here
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 README.md
```

Now let's check the log to make sure everything is there:

```bash
$ git log
commit 37c5f185b7a758feba50845ed16782c6d64db622
Author: Michael Desa <michael.desa@ga.co>
Date:   Fri Nov 14 16:04:36 2014 -0800

    Put Message here
```

##And now Github! Woooo!

###Create a Repo

###Cloning a repo clone a friends
Go to a github repo
Find the repos URL

```bash
$ git clone URL
```

and now we have a copy on our computer

###Forking a repo
we use for to make our own copy of the repo that is separate from the original one

So we fork.
Then clone our copy
make changes
commit our changes

###Push

```bash
$ git push origin master
```
