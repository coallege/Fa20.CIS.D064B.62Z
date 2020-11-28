sec5m: sec5m/decrypt_midterm.exe sec5m/midterm.png
	

sec5m/decrypt_midterm.exe: misc/decrypt_midterm.cxx
	clang++ -O2 $< -o $@

sec5m/midterm.png: ACADEMIC_HONESTY.md $(wildcard sec5m/files/*)
	node misc/embed_db $@ $^

.PHONY: sec5m
