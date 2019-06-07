# kabala
- Kabala is an automated performance tester for your ruby/rails applications.
- Configure any method, class, service, $%&!! you want to test. 
- Wether you want to run your code in a single threaded, or multithreaded environement Kabala can handle it ! 
- Pre scripts and post scripts are supported. 
- A data override engine is provided for you to be able to run your test with any data and pass validations.
- Check `example_config.yml` to have an idea of how kabala can be configured
## GETTING STARTED
- install the gem
- run kabala init to generate a yml config file

## Options

- thread_count : number of parallel threads in which you want to run your code
- invocations_per_thread : number of times you want to run the code inside each thread
- klass : the class you want to instantiate
- methods : [] the chain of methods you will call on the klass
    each method has a
    - name
    - args: []
    your arg can be of type data: (check the doc for location, override, strategy...)
- scripts : script you want to run before or after (seeding db for instance)

