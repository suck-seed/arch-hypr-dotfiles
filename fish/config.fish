source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

fish_add_path /home/suckseed/.spicetify

# --- SSH Agent Auto Setup ---
# Start ssh-agent if not already running or not exported
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) >/dev/null
end

# Add SSH key if none loaded
if test (ssh-add -l ^/dev/null | string match -r "no identities" | count) -gt 0
    ssh-add ~/.ssh/id_rsa >/dev/null 2>&1
end
