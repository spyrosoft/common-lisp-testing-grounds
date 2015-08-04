;; Initialize the array using the :fill-pointer flag specifying the initial length of the array
(setf example-sparse-array (make-array 10 :fill-pointer 2 :initial-element nil))

;; It has a visible length of two, but can contain up to ten
(length example-sparse-array)

;; The functions `vector-push' and `vector-pop' are now available:
(vector-push 'a example-sparse-array)

;; It now has a length of three
(length example-sparse-array)

;; Returns the value we just pushed
(vector-pop example-sparse-array)