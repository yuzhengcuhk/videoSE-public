/***
 * Abstract class to operate with different kind of providers.
 ***/

#ifndef DBParser_h
#define DBParser_h

#include <functional>
#include <list>
#include <map>
#include <string>
#include <utility>


namespace sse {
namespace dbparser {
/* std::function<void(int)> callback */

using funcList
    = std::function<void(const std::string&, const std::list<unsigned int>&)>;
using funcPair = std::function<void(const std::string&, const unsigned int&)>;

using FPairQueue = std::list<funcPair>;
using FListQueue = std::list<funcList>;

class DBParser
{
public:
    explicit DBParser(const char* filename);
    //    virtual ~DBParser();
    virtual void parse() = 0;
    const char*  get_file();

    bool parsed();

    void addCallbackPair(const funcPair& funcCall);
    void addCallbackList(const funcList& funcCall);

    static void callFunctionsPair(const std::string& keyword,
                                  const unsigned&    doc);
    static void callFunctionsList(const std::string&         keyword,
                                  const std::list<unsigned>& documents);

    static FPairQueue pairqueue_;
    static FListQueue listqueue_;

private:
    const char* file_;
};

} // namespace dbparser
} // namespace sse

#endif /* DBParser_h */
