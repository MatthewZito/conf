# lib.<project>

## Dynamic Linking

Linking to `lib.<project>`:

```bash
# 1) include and use lib.<project> in your project
# 2) generate object file for your project
gcc -I ../path/to/lib<project> -c main.c -o main.o
# 3) generate shared object file
make
# 4) link your project to lib.<project>
gcc -o main main.o -L../path/to/lib<project> -llib<project>
# you may need to add the lib location to your PATH
```

Linking to `lib.<project>` on Windows:

```bash
# 1) include and use lib.<project> in your project
# 2) generate object file for your project
gcc -I ../path/to/lib<project> -c main.c -o main.o
# 3) generate shared object file
make win
# 3) link your project to lib.<project>
gcc -o main.exe main.o -L /path/to/lib.<project> -llib_<project>.dll
# you may need to add the lib location to your PATH
```
