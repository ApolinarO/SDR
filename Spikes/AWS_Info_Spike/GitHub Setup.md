# Step 1: GitHub setup and cloning the project
The purpose of this spike it to get you familiar with cloning the project itself and updating your local repository. This is particularly useful when installing or upgrading to the latest version of WranglR.

## Cloning the project
To clone the project, you do not need a GitHub account. To get the latest copy of WranglR, run the following:

	git clone https://github.com/apolinaro/sdr

This will create a file called "sdr" in your current directory. If you have an existing "sdr" file and you want to update your local repo, simply remove the directory with the following:

	rm -rf sdr

Then run the git clone command again. To keep a copy of the older "sdr" version, run the following instead of the rm command:

	mv sdr sdr_old_file

Where sdr_old_file is any name you want.
