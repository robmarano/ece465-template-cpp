/**

threaded-server.cpp

Copyright (c) 2019 Rob Marano, rob@konsilix.com, http://www.konsilix.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

#include <iostream>
#include <boost/asio.hpp>
#include <boost/thread.hpp>
#include <boost/chrono.hpp>
#include "../common/common.hpp"

using namespace boost::asio;
using ip::tcp;
using std::cout;
using std::endl;
using std::string;

string read_(tcp::socket &socket)
{
    boost::asio::streambuf buf;
    boost::asio::read_until(socket, buf, "\n");
    string data = boost::asio::buffer_cast<const char *>(buf.data());
    return data;
}
void send_(tcp::socket &socket, const string &message)
{
    const string msg = message + "\n";
    boost::asio::write(socket, boost::asio::buffer(message));
}

void wait(int seconds)
{
    boost::this_thread::sleep_for(boost::chrono::seconds(seconds));
}

void threaded_socket_processing(void)
{
    boost::asio::io_service io_service;

    // listen for new connection
    tcp::acceptor acceptor_(io_service, tcp::endpoint(tcp::v4(), 1234));

    // socket creation
    tcp::socket socket_(io_service);

    // waiting for connection
    acceptor_.accept(socket_);

    // read operation
    string message = read_(socket_);
    cout << message << endl;

    // write operation
    send_(socket_, "Hello From Server!");
    cout << "Server sent Hello message to Client!" << endl;

    wait(5);
}

int main(int argc, char *argv[])
{
    cout << "main: startup"
         << " at " << boost::chrono::system_clock::now() << endl;
    boost::thread workerThread(threaded_socket_processing);

    cout << "main: waiting for thread" << endl;
    workerThread.join();

    cout << "main: done"
         << " at " << boost::chrono::system_clock::now() << endl;
    return 0;
}