## compile c program
`gcc -o hellomake hellomake.c hellofunc.c -I.`

## compile c++ program
```
g++ -Wall -std=c++11 your_file.cpp -o your_program  // or
g++ -Wall -std=c++0x your_file.cpp -o your_program  // -g enable debugging information
```
## compile java program
```
javac -g Foo.java  // -g enable debugging information
java Foo 3 2
java <class with main method to run> [<command line args>, ...]  // jdb to debug

javac @path1\options @path2\classes

javac -classpath \examples \examples\greetings\Hi.java
javac -classpath \examples;\lib\Banners.jar \examples\greetings\Hi.java
java -classpath \examples;\lib\Banners.jar greetings.Hi
```

