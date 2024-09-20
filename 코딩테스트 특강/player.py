players = ["mumu", "soe", "poe", "kai", "mine"]
callings = ["kai", "kai", "mine", "mine"]

def solution(players, callings):
    for c in callings: # O(N)
        # 호명 받은 선수의 위치 찾기
        idx = players.index(c) # O(N)
        players[idx-1], players[idx] = players[idx], players[idx-1]
        
    return players
# => O(N^2)

def solution2(players, callings):
    player_dict = {}
    for i in range(len(players)):
        player_dict[players[i]] = i
        
    for c in calling:
        idx = player_dict[c] # 호명 받은 선수의 등수(인덱스)
        
        players[idx-1], players[idx] = players[idx], players[idx-1]
        
        # 앞선수 이름
        front_player = players[idx-1]
        
        # 등수 업데이트
        player_dict[c] = idx -1 # 호명 받은 선수는 앞선수를 제쳤기 때문에 인덱스가 하나
        player_dict[front_player] = idx
        
return players