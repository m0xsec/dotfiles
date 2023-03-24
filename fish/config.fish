# Are we interactive yet?
if status is-interactive
    # Vars
    set -gx KITTY_CONFIG_DIRECTORY $HOME/sandbox/dotfiles/kitty/
    set -gx GOPATH $HOME/sandbox/go
    set -gx EDITOR vim
    set -gx PAGER less
    set -gx CLICOLOR 1
    set -gx OPENCV_LOG_LEVEL 0
    set -gx OPENCV_VIDEOIO_PRIORITY_INTEL_MFX 0
    set -gx LIBVA_DRIVER_NAME nvidia
    set -gx XDG_SESSION_TYPE wayland
    set -gx GBM_BACKEND nvidia-drm
    set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
    set -gx WLR_NO_HARDWARE_CURSORS 1
    set -gx MOZ_ENABLE_WAYLAND 1
    set -gx WLR_RENDERER vulkan
    set -gx LIBVA_DRIVERS_PATH /usr/lib/dri
    set -gx LIBGL_DRIVERS_PATH /usr/lib/dri
    set -gx GBM_BACKENDS_PATH /usr/lib/gbm

    # Path
    fish_add_path $GOPATH/bin $HOME/.local/bin $HOME/.cargo/bin

    # direnv
    set -g direnv_fish_mode eval_on_arrow
    direnv hook fish | source

end
