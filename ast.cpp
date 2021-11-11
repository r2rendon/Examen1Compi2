#include "ast.h"
#include <map>
#include <iostream>

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