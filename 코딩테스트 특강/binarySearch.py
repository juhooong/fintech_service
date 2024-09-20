def binary_search(array, value):
    # 먼저 찾으려는 값이 있을 수 있는 하한선, 상한선을 정한다.
    lower_bound = 0
    upper_bound = len(array)-1
    
    # 상한선과 하한선 사이의 가운데 값을 계속 확인하는 반복문을 수행
    while lower_bound <= upper_bound: 
        # 상한선과 하한선의 중간지점을 찾는다.
        midpoint = ( lower_bound + upper_bound ) // 2
        
        # 중간지점의 값을 확인한다.
        midvalue = array[midpoint]
        
        # 1) 해당 중간지점의 값이 찾고 있던 값이라면, 검색을 종료
        if midvalue == value:
            return midpoint
        # 2) 중간지점의 값이 찾고 있던 값보다 크면, 상한선을 중간지점보다 하나 작은 위치로 이동
        elif midvalue > value:
            upper_bound = midpoint - 1
        # 3) 중간지점의 값이 찾고 있던 값보다 작으면, 하한선을 중간지점보다 하나 큰 위치로 이동
        elif midvalue < value:
            lower_bound = midpoint + 1
    # 상한선과 하한선이 같아질 때까지 반복 완료 -> 찾고 있는 값이 배열에 없다 -> 찾고 있는 값의 위치를 반환
    return lower_bound

array = [3,17,75,80,100]
value = 22 # return 값: 2
print(binary_search(array, value))
value = 80 # return 값: 3
print(binary_search(array, value))