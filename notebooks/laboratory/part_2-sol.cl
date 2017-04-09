// C version of Java's String hash code function
// Adapted from https://docs.oracle.com/javase/1.5.0/docs/api/java/lang/String.html#hashCode()
kernel void java_hash(constant char *words,
                      constant int *offset,
                      constant int *length,
                      global int *hashes){
    int gid = get_global_id(0); //Which word are we interested in
    
    int hash = 0; //Our hash value
    
    int word_start = offset[gid]; //Where the word starts
    int word_end = word_start + length[gid]; //Where the word stops 

    //Going over the length of the word
    for (int i = word_start; i < word_end; ++i) {
        hash = 31*hash + words[i];
    }
    hashes[gid] = hash; //Writing our result back
}

#define BATCH_SIZE 2
#define CACHE_SIZE 50

// C version of Java's String hash code function
// Adapted from https://docs.oracle.com/javase/1.5.0/docs/api/java/lang/String.html#hashCode()
kernel void java_hash_batched(global char *words,
                      global int *offset,
                      global int *length,
                      global int *hashes){

    int gid = get_global_id(0); //Which word are we interested in
    
    int index = gid * BATCH_SIZE;
    
    //Copying the values into local memory
    int private_offset[BATCH_SIZE], private_length[BATCH_SIZE];
    
    int b,temp_offset = 0;
    for(b = 0; b < BATCH_SIZE; ++b){
        private_length[b] = length[index+b];
        
        private_offset[b] = temp_offset;
        temp_offset += private_length[b];
    }
    
    
    //Copying the words across
    char private_words[CACHE_SIZE];
    int cache_start = offset[index];
    int cache_end = offset[index + BATCH_SIZE-1] + private_length[BATCH_SIZE-1];
    
    int c;
    for(c = cache_start; c < cache_end; ++c){
        private_words[c - cache_start] = words[c];
    }
    
    int i,hash,word_start,word_end, private_hashes[BATCH_SIZE];
    for(b = 0;b < BATCH_SIZE;++b){
        hash = 0;
    
        word_start = private_offset[b]; //Where the word starts
        word_end = word_start + private_length[b]; //Where the word stops
        
        //Calculating the hash
        for (i = word_start; i < word_end; i++){
          hash = 31*hash + private_words[i];
        }
        
        private_hashes[b] = hash; //Writing our result back
    }
    
    
    //Copying the result out
    for(b = 0; b < BATCH_SIZE; ++b){
        hashes[index+b] = private_hashes[b];
    }
}