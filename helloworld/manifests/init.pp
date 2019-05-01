class helloworld (
  $file_path = undef
){
  notify { "Hello world!": message => "I am in the ${environment} environment"}
  unless $file_path == undef {
    file{ $file_path :
      ensure    => file,
      content  => "I am in the ${environment} environment",
    }
  }
}
