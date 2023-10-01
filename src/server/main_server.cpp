/**

main-server.cpp

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

#include "threaded_server.hpp"
//#include "../common/common.hpp"

using namespace boost::asio;
using ip::tcp;
using std::cout;
using std::endl;
using std::string;

int main(int argc, char *argv[])
{
    cout << "main: startup"
         << " at " << boost::chrono::system_clock::now() << endl;
    try {
        run_server();
    } catch (boost::exception &e) {
        std::cerr << boost::diagnostic_information(e);
    }
    cout << "main: done"
         << " at " << boost::chrono::system_clock::now() << endl;
    return 0;
}