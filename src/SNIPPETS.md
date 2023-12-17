# SNIPPETS

```c++
// set_result has a zk::stat for the modified ZNode.
    const char *str1 = "some data";
    zk::buffer buf1(str1, str1 + strlen(str1));
    // size_t length = sizeof(array_of_characters);
    // std::vector<char> vector_of_characters = new zk::buffer(*array_of_characters, array_of_characters + length);
    // client.set("/foo/bar", "some data")
    // client.set("/foo/bar", vector_of_characters)
    // client.set("/foo/bar", buf1)
    client.set("/foo/bar", buffer_from("some data"))
        .then(print_thing<zk::set_result>);

    // More explicit: client.create("/foo/baz", "more data", zk::acls::open_unsafe(), zk::create_mode::normal);
    const char *str2 = "more data";
    zk::buffer buf2(str2, str2 + strlen(str2));
    // vector_of_characters(array_of_characters, array_of_characters + sizeof(array_of_characters));
    // client.create("/foo/baz", "more data")
    // client.create("/foo/baz", vector_of_characters)
    // client.create("/foo/baz", buf2)
    client.create("/foo/baz", buffer_from("more data"))
        .then(print_thing<zk::create_result>);
```