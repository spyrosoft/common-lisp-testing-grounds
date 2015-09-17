;; Without #.
'(coin-flip
  (timestamp
   (get-internal-real-time))
  (heads-or-tails
   (if (zerop (random 2)) 'heads 'tails)))
;; (COIN-FLIP (TIMESTAMP (GET-INTERNAL-REAL-TIME))
;;  (HEADS-OR-TAILS
;;   (IF (ZEROP (RANDOM 2))
;;       'HEADS
;;       'TAILS)))

;; With #.
'(coin-flip
  (timestamp
   #.(get-internal-real-time))
  (heads-or-tails
   #.(if (zerop (random 2)) 'heads 'tails)))
;; (COIN-FLIP (TIMESTAMP 614296) (HEADS-OR-TAILS HEADS))