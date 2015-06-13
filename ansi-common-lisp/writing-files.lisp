(with-open-file (file-stream "/tmp/example-output-file.txt"
		:direction :output
		:if-exists :supersede
		:if-does-not-exist :create)
	(format file-stream "String to put in file."))