package examples.cats;

import com.intuit.karate.junit5.Karate;

class BreedsRunner {
    
    @Karate.Test
    Karate testCats() {
        return Karate.run("breeds").relativeTo(getClass());
    }    

}
