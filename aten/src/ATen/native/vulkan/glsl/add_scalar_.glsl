#version 450 core
layout(std430) buffer;
layout(std430) uniform;

layout(set = 0, rgba16f, binding = 0) writeonly highp uniform image3D uOutput;
layout(set = 0, binding = 2) uniform constBlock {
  ivec4 sizes;
  float other;
}
uConstBlock;

layout(local_size_x_id = 1, local_size_y_id = 2, local_size_z_id = 3) in;

void main() {
  ivec3 pos = ivec3(gl_GlobalInvocationID);
  if (all(lessThan(pos, uConstBlock.sizes.xyz))) {
    imageStore(
        uOutput,
        pos,
        imageLoad(uOutput, pos) + uConstBlock.other);
  }
}
