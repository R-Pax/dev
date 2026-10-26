#include QMK_KEYBOARD_H

void keyboard_post_init_user(void) {
    rgb_matrix_disable_noeeprom();
}

