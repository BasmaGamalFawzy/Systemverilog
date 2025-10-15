 //Semaphore: Basics, new() , put(), get()
// Semaphore allow limitted number of threads to access the task 
// number of keys available to access the resources is determine by new(n) if n not specified it is 1
// each thread call the task, the task will reserve a key using get(1)
// and release the key using put(1) after it is done with the resource
// if the number of keys is 2, then only 2 threads can access the resource at the same time
// if a thread tries to access the resource when all keys are taken, it will block until a key is available
 module tb;
 // semaphore is a way to limit access to a resource
 semaphore sem;
    
    task automatic access_resource(int id);
    begin 
    //The get() method is a blocking method and execution continues after successful key or keys are obtained
    sem.get(1);
    $display("Thread %0d has accessed the resource @ %0t", id , $time);
    //The put() method releases the taken keys
    #20ns sem.put(1);
    $display("Thread %0d has released the resource @ %0t", id , $time);
    end
    endtask

    initial begin 
    // Create a semaphore with an initial count of 2
    sem = new(2);
        fork
            access_resource(1);
            access_resource(2);
            // Thread #3 won't get access 
            access_resource(3);
            #10ns access_resource(4);
            #10ns access_resource(5);
            
        join
 end

 endmodule