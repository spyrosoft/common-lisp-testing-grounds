;; MD5 Hash
(ironclad:byte-array-to-hex-string
 (ironclad:digest-sequence :md5 (ironclad:ascii-string-to-byte-array "testing")))