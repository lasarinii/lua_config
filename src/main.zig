const std = @import("std");

fn get_config() ![][]const u8 {
    if (!std.process.can_execv) {
        return error.CanNotExecv;
    }

    var allocator = std.heap.GeneralPurposeAllocator(.{}){};

    const res = try std.process.Child.run(.{
        .allocator = allocator.allocator(),
        .argv = &[_][]const u8{"/home/lasarinii/Code/lua_config/c"},
    });

    var items = std.mem.split(u8, res.stdout, " ");
    var out: [3][]const u8 = undefined;
    var count: usize = 0;
    while (items.next()) |i| {
        out[count] = i;
        count += 1;
    }
    return &out;
}

pub fn main() !void {
    const out = try get_config();

    const x_str = out[0][0 .. out[0].len - 0];
    const y_str = out[1][0 .. out[1].len - 1];
    const x = try std.fmt.parseInt(i32, x_str, 10);
    const y = try std.fmt.parseInt(i32, y_str, 10);

    var i: i32 = 0;
    var j: i32 = 0;
    while (x > i) : (i += 1) {
        while (y > j) : (j += 1) {
            try std.io.getStdOut().writer().print("{s}", .{"# "});
        }
        try std.io.getStdOut().writer().print("\n", .{});
        j = 0;
    }
}
