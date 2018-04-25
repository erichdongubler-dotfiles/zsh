fancy_diff_setup () {
	echo "Totes corrupting Git config..."
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	echo "  Done!"
}

zplug "so-fancy/diff-so-fancy", as:command, use:diff-so-fancy, hook-build:"fancy_diff_setup"
zplug "wfxr/forgit", defer:1
