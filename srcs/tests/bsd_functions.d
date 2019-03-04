extern (C) {
    version (OSX) {
        int isascii(int c);
    }

    version (linux) {
        int isascii(int c) {
            return (c >= 0 && c <= 127);
        }
    }
}
