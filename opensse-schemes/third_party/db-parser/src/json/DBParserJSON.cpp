#include "json/DBParserJSON.h"

#include "json/rapidjson/document.h"
#include "json/rapidjson/filereadstream.h"

#include <cstdio>

#include <iostream>


namespace sse {
namespace dbparser {

struct DBParserJSON::MessageHandler
    : public rapidjson::BaseReaderHandler<rapidjson::UTF8<>, MessageHandler>
{
    bool StartObject()
    {
        switch (state_) {
        case State::kExpectObjectStart:
            state_ = State::kExpectKeyOrObjectEnd;
            return true;
        default:
            return false;
        }
    }

    bool Key(const char* str, rapidjson::SizeType length, bool /* unused */)
    {
        switch (state_) {
        case State::kExpectKeyOrObjectEnd:
            keyword_ = std::string(str, length);
            state_   = State::kExpectStartList;
            return true;
        default:
            return false;
        }
    }

    bool StartArray()
    {
        switch (state_) {
        case State::kExpectStartList:
            state_ = State::kExpectFirstValue;
            return true;
        default:
            return false;
        }
    }

    bool Uint(unsigned i)
    {
        switch (state_) {
        case State::kExpectFirstValue:
            ids_.push_back(i);
            state_ = State::kExpectValueOrEndArray;
            callFunctionsPair(keyword_, ids_.back());
            return true;
        case State::kExpectValueOrEndArray:
            ids_.push_back(i);
            callFunctionsPair(keyword_, ids_.back());
            return true;
        default:
            return false;
        }
    }

    bool EndArray(rapidjson::SizeType /* elementCount */)
    {
        switch (state_) {
        case State::kExpectValueOrEndArray:
            state_ = State::kExpectKeyOrObjectEnd;

            callFunctionsList(keyword_, ids_);

            keyword_.clear();
            ids_.clear();
            return true;
        default:
            return false;
        }
    }

    bool EndObject(rapidjson::SizeType /*unused*/)
    {
        return state_ == State::kExpectKeyOrObjectEnd;
    }

    bool Default()
    {
        return false;
    } // All other events are invalid.

    enum class State : uint8_t
    {
        kExpectObjectStart,
        kExpectKeyOrObjectEnd,
        kExpectStartList,
        kExpectFirstValue,
        kExpectValueOrEndArray,
    } state_{State::kExpectObjectStart};

    std::string         keyword_;
    std::list<unsigned> ids_;
};

DBParserJSON::DBParserJSON(const char* filename) : DBParser(filename)
{
}

DBParserJSON::DBParserJSON(const std::string& filename)
    : DBParser(filename.c_str())
{
}

void DBParserJSON::parse()
{
    if (!parsed_) {
        FILE*                     fp = fopen(get_file(), "r");
        char                      readBuffer[65536];
        rapidjson::FileReadStream is(fp, readBuffer, sizeof(readBuffer));

        MessageHandler    handler;
        rapidjson::Reader reader;

        reader.Parse(is, handler);

        fclose(fp);
        parsed_ = true;
    }
}

bool DBParserJSON::parsed()
{
    return parsed_;
}

} // namespace dbparser
} // namespace sse
