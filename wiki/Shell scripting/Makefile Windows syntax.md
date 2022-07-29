Using GNU Make on Windows

```make
choco install make
```

Running different commands on Windows:

```make
target:
ifeq ($(OS),Windows_NT)
	powershell -NoProfile -Command "Get-Date"
else
	date
endif
```