-module(rebar3_auto_env_prv).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, rebar3_auto_env).
-define(DEPS, [app_discovery]).

%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider = providers:create([
            {name, ?PROVIDER},            % The 'user friendly' name of the task
            {module, ?MODULE},            % The module implementation of the task
            {bare, true},                 % The task can be run by the user, always true
            {deps, ?DEPS},                % The list of dependencies
            {example, "rebar3 rebar3_auto_env"}, % How to use the plugin
            {opts, []},                   % list of options understood by the plugin
            {short_desc, "Rebar3 Automatic Environment Hook"},
            {desc, "Rebar3 Automatic Environment Hook"}
    ]),
    {ok, rebar_state:add_provider(State, Provider)}.


-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    {ok, _} = application:ensure_all_started(sasl),
    {ok, _} = application:ensure_all_started(gendb),
    io:format("SUCCESS\n"),
    {ok, State}.

-spec format_error(any()) ->  iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).
