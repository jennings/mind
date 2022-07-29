# `sort`

Sorts on a column.

```bash
$ sort makes.txt
1 volkswagen
2 honda
3 ford

$ sort -k2 makes.txt
3 ford
2 honda
1 volkswagen
```

# `uniq`

Output unique rows, optionally with counts. Input must be sorted

```bash
# Show line counts
$ sort names.txt | uniq -c
2 alice
1 bob
1 carol

# Only show duplicated lines
$ sort names.txt | uniq -d
alice

# Only show non-duplicated lines
$ sort names.txt | uniq -d
bob
carol
```

# `join`

Join two files. Files must be sorted.

```bash
# join two files on column 1 of the first file and column 2 of the second
$ join -2 2 <(sort makes.txt) <(sort -k2 models.txt)
1 volkswagen 2 beetle
1 volkswagen 1 gti
2 honda 4 civic
2 honda 3 cr-v
3 ford 5 f150
3 ford 6 mustang

# only output some fields (all three forms produce the same output)
$ join -2 2 -o 1.2,2.3 <(sort makes.txt) <(sort -k2 models.txt)
$ join -2 2 -o "1.2 2.3" <(sort makes.txt) <(sort -k2 models.txt)
$ join -2 2 -o 1.2 -o 2.3 <(sort makes.txt) <(sort -k2 models.txt)
volkswagen beetle
volkswagen gti
honda civic
honda cr-v
ford f150
ford mustang
```

# `comm`

Select or reject lines common to two files, producing three columns:

* Lines only in file 1
* Lines only in file 2
* Lines in both files

```bash
$ cat >cars.txt <<HERE
gti
beetle
civic
mustang
328i
HERE

$ comm <(awk '{print $3}' models.txt | sort) <(sort cars.txt)
	328i
		beetle
		civic
cr-v
f150
		gti
		mustang
```

# `paste`

Output columns

```bash
# reading from files
$ paste names.txt <(sort names.txt) <(sort -r names.txt)
alice	alice	carol
bob	alice	bob
alice	bob	alice
carol	carol	alice

# reading from stdin
$ paste - - - <names.txt
alice	bob	alice
carol

# change the separator character
$ paste -d '|' - - - <names.txt
alice|bob|alice
carol||
```

# Example files
makes.txt

```
1 volkswagen
2 honda
3 ford
```

models.txt

```
1 1 gti
2 1 beetle
3 2 cr-v
4 2 civic
5 3 f150
6 3 mustang
```

names.txt

```
alice
bob
alice
carol
```