# todo_enum

## List.add vs [...List, new]

- fakeTodos.add(todo.toJson())
  이 방식은 기존의 fakeTodos 리스트에 직접적으로 항목을 추가하는 방식입니다.
  add 메서드는 리스트의 마지막에 요소를 제자리에서 추가(mutate)합니다.
  즉, 리스트 자체는 변경되지만, 새로운 리스트가 생성되지 않습니다.

- fakeTodos = [...fakeTodos, todo.toJson()]
  이 방식은 기존의 리스트 요소들을 복사한 새로운 리스트를 만들고, 그 리스트에 todo.toJson()을 추가하여 새 리스트로 대입하는 방식입니다.
  기존 리스트의 참조를 유지하지 않고, 새로운 리스트를 생성하여 fakeTodos에 할당합니다.

- 어떤 것을 사용해야 할까?

  add 방식은 성능 면에서 더 효율적이며, 리스트의 참조를 유지해야 할 때 사용됩니다. 즉, 리스트를 직접 수정하고 불변성이 중요한 문제가 아닐 때 적합합니다.

  스프레드 연산자 방식 ([...fakeTodos, todo.toJson()])은 **불변성(immutability)**을 유지하고자 할 때 더 적합합니다. 새로운 리스트를 생성하여 기존 리스트를 변경하지 않음으로써, 다른 코드에서 fakeTodos를 참조하고 있을 때 예상치 못한 부작용을 방지할 수 있습니다. 이 방식은 특히 상태 관리 패턴에서 자주 사용됩니다 (예: Redux, Provider 등).

## 순서

1. TodosRepository 추상 클래스
2. FakeTodosRepository 구현
   - Future, async
3. todosRepositoryProvider 생성 TodosRepository 반환 (단순 프로바이더. ref.read().함수())
4. main ProviderScope를 사용 TodosRepository를 FakeTodosRepository 오버라이드
5. TodoListState 클래스 생성
   - enum TodoListStatus
   - List<Todo>
   - String error
6. TodoListProvider 리팩토링
   - 상태 변경
   - 데이터 변경 (CRUD)
