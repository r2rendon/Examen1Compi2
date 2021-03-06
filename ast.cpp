#include "ast.h"
#include <map>
#include <iostream>

map<string, float> globalVariables = {};

float NumExpr::evaluate(){
    return this->number;
}

float AddExpr::evaluate(){
    return this->expr1->evaluate() + this->expr2->evaluate();
}

float SubExpr::evaluate(){
    return this->expr1->evaluate() - this->expr2->evaluate();
}

float MulExpr::evaluate(){
    return this->expr1->evaluate() * this->expr2->evaluate();
}

float DivExpr::evaluate(){
    return this->expr1->evaluate() / this->expr2->evaluate();
}

float GTExpr::evaluate(){
    return this->expr1->evaluate() > this->expr2->evaluate();
}

float LTExpr::evaluate(){
    return this->expr1->evaluate() < this->expr2->evaluate();
}

float Initializer::evaluate() {
    return this->expression->evaluate();
}

float Declaration::evaluate(){
    globalVariables[this->id] = this->val->evaluate();
    printf("\nVariable %s declarada\n", this->id);
    return 0;
}

float WhileStatement::evaluate(){
    while (this->expr != 0)
    {
        this->stmt->evaluate();
    }

    return 0;
}
