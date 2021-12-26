# RandomWallpaper
My arch script for randomizing a wallpaper, generating its palette, and putting is in a file (to source)

# Requirements:

- [pywal](https://github.com/dylanaraps/pywal)
- [nitrogen](https://github.com/l3ib/nitrogen) (optional, use -n option if you want to use it)

And I think that is kinda all.

# Running the script

```
./random_wallpaper.sh
```

```
        Usage:
            random_wallpaper.sh [OPTIONS]

        Options:
            -d DIRECTORY
                Path to a directory with images. (~/Pictures by default)
            -n  Use with Nitrogen
            -o  Save color scheme to another file. (~/.config/color_scheme by default)
```

Once the "color_scheme" file is created, you can `source color_scheme` to use generated colors.

Special characters used are from [FontAwesome](https://fontawesome.com/icons). If you don't have this font installed, you won't see the icons.