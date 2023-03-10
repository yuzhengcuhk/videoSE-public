#ifndef DBParserJSON_h
#define DBParserJSON_h

#include <sse/dbparser/DBParser.h>

#include <cstdio>

#include <iostream>
#include <list>

namespace sse {
namespace dbparser {

class DBParserJSON : public DBParser
{
public:
    explicit DBParserJSON(const char* filename);
    explicit DBParserJSON(const std::string& filename);
    void parse() override;
    bool parsed();

private:
    bool parsed_ = false;

    struct MessageHandler;
};

} // namespace dbparser
} // namespace sse

#endif
