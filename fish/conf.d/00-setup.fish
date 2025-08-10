if not test -f ~/.cargo/env.fish
    mkdir -p ~/.cargo
    printf "%s\n" \
        "# Rust environment for Fish" >~/.cargo/env.fish
end
