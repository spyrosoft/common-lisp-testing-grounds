(defvar example-hash-table (make-hash-table))

(setf (gethash 'hash-table-key example-hash-table) "hash table value")
(print (gethash 'hash-table-key example-hash-table))

;; Redefine a key's value
(setf (gethash 'hash-table-key example-hash-table) "new hash table value")
(print (gethash 'hash-table-key example-hash-table))