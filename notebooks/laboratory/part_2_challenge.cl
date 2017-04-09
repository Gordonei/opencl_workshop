// C version of Java's String hash code function
// Adapted from https://docs.oracle.com/javase/1.5.0/docs/api/java/lang/String.html#hashCode()
kernel void java_hash(constant char *words,
                      constant int *offset,
                      constant int *length,
                      global int *hashes){
    int gid = get_global_id(0); //Which word are we interested in
       
    int word_start = offset[gid]; //Where the word starts
    int word_end = word_start + length[gid]; //Where the word stops 

    //Going over the length of the word
    hashes[gid] = 0;
    for (int i = word_start; i < word_end; ++i) {
        hashes[gid] = 31*hashes[gid] + words[i];
    }
}