sec5m: ../sec5m/decrypt_midterm.exe ../sec5m/midterm.png
	

../sec5m/decrypt_midterm.exe: decrypt_midterm.cxx
	clang++ -O2 $< -o $@

../sec5m/midterm.png: ../sec5m/midterm.sql ../ACADEMIC_HONESTY.md
	node embed_db $@ $^

.PHONY: sec5m
