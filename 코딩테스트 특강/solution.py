s = "(())()("

def solution(s):
    stack = []
    for b in s:
        if b == "(":
            stack.append(b) # 열린 괄호를 저장 O(1)
        else: # ")" 닫힘괄호가 나올 때
            if stack == []: # 열리지 않았는데 닫힘 or 다 짝지어졌는데 닫힘이 들어옴
                return True
            else:
                stack.pop() # 스택의 맨 끝 데이터를 제거(짝지어줌) O(1)
    if stack != []:
        return False
    else:
        return True
    
# O(N)