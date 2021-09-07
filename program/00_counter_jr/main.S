

            .text

            move    $t0, $0
            addiu   $t0, $t0, 3
start:      move    $v0, $0
counter:    addiu   $v0, $v0, 1
            jr      $t0
