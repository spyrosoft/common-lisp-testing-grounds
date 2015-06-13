(defvar example-hash-table (make-hash-table))

;; Set a value
(setf (gethash "hash-table-key" example-hash-table) "hash table value")
(print (gethash "hash-table-key" example-hash-table))

;; Redefine a key's value
(setf (gethash "hash-table-key" example-hash-table) "new hash table value")
(print (gethash "hash-table-key" example-hash-table))

;; Set additional values
(setf (gethash "second-hash-table-key" example-hash-table) "two")
(setf (gethash "third-hash-table-key" example-hash-table) "three")

;; Get all keys
(defun get-hash-table-keys (hash-table)
  (loop for key being the hash-keys of hash-table collect key))

(get-hash-table-keys example-hash-table)