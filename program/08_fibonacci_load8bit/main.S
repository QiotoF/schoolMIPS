

            .text

            # load    $5
start:      move    $t0, $0
            li      $t1, 1
            move    $v0, $t1
            move    $t3, $0

fibonacci:  addu    $t0, $t0, $t1
            move    $v0, $t0
            addu    $t1, $t0, $t1
            move    $v0, $t1
            addiu   $t3, $t3, 1
            bne     $t3, $a1,  fibonacci
