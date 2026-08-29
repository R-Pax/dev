export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
export PATH="/opt/homebrew/opt/arm-none-eabi-gcc@8/bin:$PATH"
export PATH="/opt/homebrew/opt/arm-none-eabi-binutils/bin:$PATH"

precmd() {
  print -n "\n\n\n\n\n\n\n\n"
  print -n "\e[8A"
}
