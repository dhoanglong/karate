package examples.cats;

import com.intuit.karate.junit5.Karate;

class favouritesRunner {
    
    @Karate.Test
    Karate testCats() {
        return Karate.run("favourites").relativeTo(getClass());
    }    

}
